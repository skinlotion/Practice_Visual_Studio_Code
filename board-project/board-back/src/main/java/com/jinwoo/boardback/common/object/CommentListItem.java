package com.jinwoo.boardback.common.object;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentListItem {
    private String nickName;
    private String profileImage;
    private String writeDatetime;
    private String content;

    public CommentListItem(commentListResultSet resultSet) {
        this.nickname = resultSet.getNickname();
        this.content = resultSet.getContent();
        this.writeDatetime = result.getWriteDatetime();
        this.profileImage = result.getProfileImage();
    }

    public static List<CommentListItem> getList(List<commentListResultSet> resultSets) {
        List<CommentListItem> list = new ArrayList<>();
        for (CommentListResultSet resultSet : resultSets) {
            CommentListItem commentListItem = new CommentListItem(resultSet);
            list.add(commentListItem);
        }
        return list;
    }
}
