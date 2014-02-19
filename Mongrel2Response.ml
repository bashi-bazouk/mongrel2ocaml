open String
open List
open Printf

type mongrel2_response = {
  uuid: string;
  ids: int list;
  body: string }

let string_of_response (r: mongrel2_response): string =
  let netstring_of_string s = (string_of_int (String.length s)) ^ ":" ^ s in
  let ids = (String.concat " " (map string_of_int r.ids)) in
  sprintf "%s %s, %s" r.uuid ids r.body
