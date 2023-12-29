let possiblyNullValue1 = None
let possiblyNullValue2 = Some("Hello")

switch possiblyNullValue2 {
| None => Js.log("Nothing to see here.")
| Some(message) => Js.log(message)
}

type universityStudent = {gpa: float}

type response<'studentType> = {
  status: int,
  student: 'studentType,
}

let student1 = {
  "name": "John",
  "age": 30,
}

type payload = {
  name: string,
  age: int,
}

let student2 = {
  name: "John",
  age: 30,
}

let greetByName = (possiblyNullName) => {
  let optionName = Js.Nullable.toOption(possiblyNullName)
  switch optionName {
  | None => "Hi"
  | Some(name) => "Hello " ++ name
  }
}
