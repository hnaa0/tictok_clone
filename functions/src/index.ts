import * as admin from "firebase-admin";
import * as functions from "firebase-functions";


admin.initializeApp();

// 새 영상이 있는지 listen하고 db에 추가 후 정보를 영상에 추가
export const onVideoCreated = functions.firestore.document("videos/{videoId}").onCreate(async (snapshot, context) =>{
    const spawn = require("child-process-promise").spawn;
    const video = snapshot.data();

    await spawn("ffmpeg", [
        // 1. 영상 파일 경로 입력
        // 2. 영상의 타임라인 이동
        // 3. 영상 프레임 가져오기
        // 4. 필터 추가
        // 5. 저장 경로 설정
        "-i",
        video.fileUrl,
        "-ss", 
        "00:00:01.000",
        "-vframes", 
        "1",
        "-vf", 
        "scale=150:-1", // -1로 설정시 ffmpeg가 영상 비율에 맞춰서 높이 설정
        `/tmp/${snapshot.id}.jpg`,
    ]);

    const storage = admin.storage();
    const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
      destination: `thumbnails/${snapshot.id}.jpg`,
    });

    await file.makePublic();
    await snapshot.ref.update({thumbnailUrl : file.publicUrl()});
    const db = admin.firestore();

    await db.collection("users")
    .doc(video.creatorUid)
    .collection("videos")
    .doc(snapshot.id)
    .set({
        thumbnailUrl : file.publicUrl(),
        videoId: snapshot.id,
    });
});

export const onLikedCreated = functions.firestore.document("likes/{likeId}")
.onCreate( async (snapshot, context) => {
    const db = admin.firestore();
    const [videoId, userId] = snapshot.id.split("000");
    const video = await db.collection("videos").doc(videoId).get();

    await db.collection("videos").doc(videoId).update({
        liked: admin.firestore.FieldValue.increment(1),
    });

    await db.collection("users").doc(userId).collection("liked").doc(videoId)
    .set({
        "thumbnailUrl": video.data()!.thumbnailUrl,
        "videoId": videoId,
        "createdAt": Date.now(),
    });
});

export const onLikedRemoved = functions.firestore.document("likes/{likeId}")
.onDelete( async (snapshot, context) => {
    const db = admin.firestore();
    const [videoId, userId] = snapshot.id.split("000");
    
    await db.collection("videos").doc(videoId).update({
        liked: admin.firestore.FieldValue.increment(-1),
    });

    await db.collection("users").doc(userId).collection("liked").doc(videoId)
    .delete();
});