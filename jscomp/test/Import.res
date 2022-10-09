let each = Js.import(Belt.List.forEach)

let eachInt = (list: list<int>, f: int => unit) =>
  Js.Promise.then_(each => list->each(f)->Js.Promise.resolve, each)

module type BeltList = module type of Belt.List

let beltAsModule = Js.import(module(Belt.List: BeltList))

let eachIntAsync = async (list: list<int>, f: int => unit) => {
  let each = await each
  list->each(f)
}

let eachLazy = () => Js.import(Belt.List.forEach)

let eachIntLazy = (list: list<int>, f: int => unit) =>
  eachLazy() |> Js.Promise.then_(each => list->each(f)->Js.Promise.resolve)
