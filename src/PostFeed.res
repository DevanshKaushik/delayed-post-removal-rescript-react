let s = React.string

open Belt

type state = {posts: array<Post.t>, forDeletion: Map.String.t<Js.Global.timeoutId>}

type action =
  | DeleteLater(Post.t, Js.Global.timeoutId)
  | DeleteAbort(Post.t)
  | DeleteNow(Post.t)

let reducer = (state, action) =>
  switch action {
  | DeleteLater(post, timeoutId) => {
      ...state,
      forDeletion: state.forDeletion->Map.String.set(post->Post.id, timeoutId),
    }
  | DeleteAbort(post) => {
      ...state,
      forDeletion: state.forDeletion->Map.String.remove(post->Post.id),
    }
  | DeleteNow(post) => {
      posts: state.posts->Js.Array2.filter(x => x->Post.id != post->Post.id),
      forDeletion: state.forDeletion->Map.String.remove(post->Post.id),
    }
  }

let initialState = {posts: Post.examples, forDeletion: Map.String.empty}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState)

  let clearTimeout = (post: Post.t) => {
    switch Map.String.get(state.forDeletion, post->Post.id) {
    | Some(timeoutId) => Js.Global.clearTimeout(timeoutId)
    | None => Js.log("ERROR: Unable to clear timeout")
    }
  }

  let posts = state.posts->Belt.Array.map(post => {
    if Map.String.has(state.forDeletion, post->Post.id) {
      let restoreHandler = _mouseEvent => {
        post->clearTimeout
        dispatch(DeleteAbort(post))
      }

      let deleteHandler = _mouseEvent => {
        post->clearTimeout
        dispatch(DeleteNow(post))
      }

      <DeletePostView post key={post->Post.id} restoreHandler deleteHandler />
    } else {
      let removeHandler = _mouseEvent => {
        let timeoutId = Js.Global.setTimeout(() => dispatch(DeleteNow(post)), 10000)
        dispatch(DeleteLater(post, timeoutId))
      }

      <PostView post key={post->Post.id} removeHandler />
    }
  })
  <div className="max-w-3xl mt-10 mx-auto"> {posts->React.array} </div>
}
