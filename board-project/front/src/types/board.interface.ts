export default interface Board {
    boardNumber : number;
    title : string;
    contents : string;
    imageUrls : string[];
    writeDatetime : string;
    writerEmail : string;
    nickname : string;
    profilImageUrl : string | null;
}