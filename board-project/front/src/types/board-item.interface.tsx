export default interface BoardItem {
    boardNumber : number;
    title : string;
    contents : string;
    imageUrl : string | null;
    viewCount : number;
    commentCount : number;
    favoritCount : number;
    writeDatetime : string;
    nickname : string;
    profileImageUrl : string | null;
}