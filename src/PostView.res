let s = React.string

let createId = (id, index) => {
  id ++ index->Belt.Int.toString
}

@react.component
let make = (~post: Post.t, ~removeHandler) => {
  let paras =
    post
    ->Post.text
    ->Belt.Array.mapWithIndex((index, para) => {
      <p className="mb-1 text-sm" key={createId(post->Post.id, index)}> {s(para)} </p>
    })

  <div className="bg-green-700 hover:bg-green-900 text-gray-300 hover:text-gray-100 px-8 py-4 mb-6">
    <h2 className="text-2xl mb-1"> {s(post->Post.title)} </h2>
    <h3 className="mb-4"> {s(post->Post.author)} </h3>
    {paras->React.array}
    <Button
      text="Remove this post"
      className="mr-4 mt-4 bg-red-500 hover:bg-red-900 text-white py-2 px-4"
      clickHandler=removeHandler
    />
  </div>
}
