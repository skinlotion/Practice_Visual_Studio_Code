import React,{useState, useEffect, ChangeEvent, useRef} from 'react';
import './style.css';
import DefaultProfileImage from 'assets/defult-profile-image.png'
import { Board, CommentItem, FavoriteItem } from 'types';
import { useParams } from 'react-router-dom';
import { boardMock, commentListMock, favoriteListMock } from 'mocks';
import { useUserStore } from 'stores';
import { usePagination } from 'hooks';
import CommentListItem from 'components/CommentListItem';
import Pageination from 'components/Pagination';

//            component : 게시물 상세보기 페이지            //
export default function BoardDetail() {
  
  //            state : 게시물 번호 path variable 상태            //
  const { boardNumber } = useParams();
  //            state : 로그인 유저 상태            /
  const { user } = useUserStore();

  //            component : 게시물 상세보기 상단 페이지            //
  const BoardDetailTop = () => {
    //            state : 작성자 상태           //
    const [isWriter, setWriter] = useState<boolean>(false);
    //            state : more button 상태            //
    const[showMore, setShowMore] = useState<boolean>(false);
    //            state : 게시물 상태           //
    const [board, setBoard] = useState<Board | null>(null);

    //            event handler : more button 클릭 이벤트 처리            // 
    const onMoreButtonClickHandler = () => {
      setShowMore(!showMore);
    }

    //            effect : 게시물 번호 path variavle이 바뀔때마다 게시물 불러오기           //
    useEffect(() => {
      setBoard(boardMock);
      if(!user) return;
      const isWriter = user.email === boardMock.writerEmail;
      setWriter(isWriter)
    },[boardNumber]);

    //            render : 게시물 상세보기 상단 페이지 랜더링            //
    return(
      <div id='board-detail-top'>
        <div className='board-detail-top-header'>
          <div className='board-detail-title'>{board?.title}</div>
          <div className='board-detail-sub-box'>
            <div className='board-detail-write-info-box'>
              <div className='board-detail-writer-profil-image' style={{ backgroundImage:`url(${DefaultProfileImage})` }}></div>
              <div className='board-detail-writer-nickname'>{board?.nickname}</div>
              <div className='board-detail-info-divider'>{'\|'}</div>
              <div className='board-detail-write-date'>{board?.writeDatetime}</div>
            </div>
            {isWriter && (
            <div className='icon-button' onClick={onMoreButtonClickHandler}>
              <div className='more-icon'></div>
            </div>
            )}
            { showMore && (
              <div className='more-box'>
                <div className='more-update-button'>{'수정'}</div>
                <div className='divider'></div>
                <div className='more-delet-button'>{'삭제'}</div>
              </div>
            )}
          </div>
        </div>
        <div className='divider'></div>
        <div className='board-detail-top-main'>
          <div className='board-detail-main-text'>{board?.contents}</div>
          {board?.imageUrls.map(imageUrl => <img className='board-detail-main-image' src={imageUrl}/> )}
        </div>
      </div>
    )
  }

  //          component: 게시물 상세보기 하단 컴포넌트          //
  const BoardDetailBottom = () => {
    //            state : 댓글 textarea 참조 상태            //
    const textareaRef = useRef<HTMLTextAreaElement | null>(null);

    //            state : 좋아요 리스트 상태           //
    const [favoriteList, setFavoriteList] = useState<FavoriteItem[]>([]);

    //            state : 댓글 리스트 페이지네이션 상태           //
    const { currentPageNumber, setCurrentPageNumber, currentSectionNumber, setCurrentSectionNumber, viewBoardList, viewPageNumberList, totalSection, setBoardList,} = usePagination<CommentItem>(3);
    //            state : 댓글 개수 상태           //
    const [commentsCount, setCommnetsCount] = useState<number>(0);

    //            state : 좋아요 박스 상태            //
    const [showFavorite, setShowFavorite] = useState<boolean>(false);
    //            state : 댓글박스 상태           //
    const [showComments, setShowComments] = useState<boolean>(false);
    //            state : 좋아요 상태           //
    const [isFavorite, setFavorite] = useState<boolean>(false);
    //            state :  댓글 상태           //
    const [comment, setComment] = useState<string>('');

    //            event handler : 좋아요 박스 보기 버튼 클릭 이벤트 처리            //
    const onShowFavoriteButtonClickHandler = () =>{
      setShowFavorite(!showFavorite);
    }
    //            event handler : 댓글 박스 보기 버튼 클릭 이벤트 처리            //
    const onShowCommentsButtonClickHandler = () =>{
      setShowComments(!showComments);
    }
    //            event handler : 좋아요 버튼 클릭 이벤트 처리            //
    const onFavoriteButtonClickHandler =() => {
      if(!user) {
        alert('로그인시 이용 가능합니다.');
        return;
      }
      // TODO : API연결로 변경
      setFavorite(!isFavorite); 
    }
    //            event handler : 댓글 변경 이벤트 처리            //
    const onCommentChangeClickHandler = (event:ChangeEvent<HTMLTextAreaElement>) => {
      const comment = event.target.value;
      setComment(comment);
      // description : textarea 내용이 바뀔때마다 높이 변경 //
      if(!textareaRef.current) return;
      textareaRef.current.style.height = 'auto';
      textareaRef.current.style.height = `${textareaRef.current.scrollHeight}px`
    }
    //            effect : 게시물 번호 path variable이 바뀔때 마다 좋아요 및 댓글 리스트 불러오기            //
    useEffect (()=>{
      setFavoriteList(favoriteListMock);
      setBoardList(commentListMock);
      setCommnetsCount(commentListMock.length);
    },[boardNumber])

    //          render: 게시물 상세보기 하단 컴포넌트 렌더링          //
    return (
      <div id='board-detail-bottom'>
        <div className='board-detail-bottom-button-box'>
          <div className='board-detail-bottom-button-group'>
            <div className='icon-button' onClick={onFavoriteButtonClickHandler}>
              {isFavorite ? (<div className='favorite-fill-icon'></div>) : (<div className='favorite-light-icon'></div>) }
            </div>
            <div className='board-detail-bottom-button-text'>{`좋아요 ${favoriteList.length}`}</div>
            <div className='icon-button' onClick={onShowFavoriteButtonClickHandler}>
              {showFavorite ?(
                <div className='up-light-icon'></div>) : (<div className='down-light-icon'></div>)}
            </div>
          </div>
          <div className='board-detail-bottom-button-group'>
            <div className='icon-box'>
              <div className='comment-light-icon'></div>
            </div>
            <div className='board-detail-bottom-button-text'>{`댓글 ${commentsCount}`}</div>
            <div className='icon-button' onClick={onShowCommentsButtonClickHandler}>
              {showComments? (<div className='up-light-icon'></div>):(<div className='down-light-icon'></div>)}
            </div>
          </div>
        </div>
        {showFavorite && (
            <div className='board-detail-bottom-favorite-box'>
              <div className='board-detail-bottom-favorite-container'>
                <div className='board-detail-bottom-favorite-title'>{'좋아요 '}<span className='emphasis'>{favoriteList.length}</span></div>
                <div className='board-detail-bottom-fvaorite-contents'>
                  {favoriteList.map(favoriteItem => (
                    <div className='board-detail-bottom-favorit-item'>
                     <div className='board-detail-bottom-favorit-profile-image' style={{backgroundImage : `url(${favoriteItem.profileImage ? (favoriteItem.profileImage) : (DefaultProfileImage)})`}}></div>
                     <div className='board-detail-bottom-favorit-nickname'>{favoriteItem.nickname}</div>
                   </div>
                  ))}
                </div>
              </div>
          </div>
          )}
          {showComments && (
            <div className='board-detail-bottom-comments-box'>
            <div className='board-detail-bottom-comments-container'>
              <div className='board-detail-bottom-comments-list-container'>
                <div className='board-detail-bottom-comments-list-title'>{'댓글'}<span className='emphasis'>{commentsCount}</span></div>
                <div className='board-detail-bottom-comments-list-contents'>
                  {viewBoardList.map(commentItem => <CommentListItem commentItem={commentItem}/>)}
                </div>
              </div>
            </div>
            <div className='divider'></div>
            <div className='board-detail-bottom-comments-pagination-box'>
            <Pageination
              currentPageNumber = {currentPageNumber}
              currentSectionNumber = {currentSectionNumber}
              setCurrentPageNumber = {setCurrentPageNumber}
              setCurrentSectionNumber = {setCurrentSectionNumber}
              viewPageNumberList={viewPageNumberList}
              totalSection={totalSection}
            />
            </div>
            {user !== null && (
              <div className='board-detail-bottom-comments-input-box'>
                <div className='board-detail-bottom-comments-input-container'>
                  <textarea ref={textareaRef} className='board-detail-bottom-comments-input' placeholder='댓글을 작성해주세요.' value={comment} onChange={onCommentChangeClickHandler}/>
                    <div className='board-detail-bottom-comments-button-box'>
                      {comment.length === 0 ? (
                        <div className='board-detail-bottom-comments-button-disable'>{'댓글달기'}</div>
                      ) : (
                        <div className='board-detail-bottom-comments-button'>{'댓글달기'}</div>
                      )} 
                    </div>
                </div>
              </div>
            )}
            </div>
          )}
      </div>
    )
  }

  //          render: 게시물 상세보기 페이지 렌더링          //
  return (
    <div id='board-detail-wrapper'>
      <div className='board-detail-container'>
        <BoardDetailTop />
        <BoardDetailBottom />
      </div>
    </div>
  )
} 