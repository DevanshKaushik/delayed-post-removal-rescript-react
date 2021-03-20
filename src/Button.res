@react.component
let make = (~text, ~className, ~clickHandler) => {
  <button className onClick=clickHandler> {React.string(text)} </button>
}
