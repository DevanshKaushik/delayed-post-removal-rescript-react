@react.component
let make = (~post: Post.t, ~restoreHandler, ~deleteHandler) => {
  <div className="relative bg-yellow-100 px-8 py-4 mb-6 h-40 rounded-md">
    <p className="text-center white mb-1">
      {React.string(
        `This post from ${post->Post.title} by ${post->Post.author} will be permanently removed in 10 seconds.`,
      )}
    </p>
    <div className="flex justify-center">
      <Button
        text="Restore"
        className="mr-4 mt-4 bg-yellow-500 hover:bg-yellow-900 text-white py-2 px-4"
        clickHandler=restoreHandler
      />
      <Button
        text="Delete Immediately"
        className="mr-4 mt-4 bg-red-500 hover:bg-red-900 text-white py-2 px-4"
        clickHandler=deleteHandler
      />
    </div>
    <div className="bg-red-500 h-2 w-full absolute bottom-0 left-0 progress" />
  </div>
}
