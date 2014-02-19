open List

type response = {
  uuid: string;
  ids: int list;
  body: string }

let string_of_response (r: response): string =
  let netstring_of_string s = (string_of_int (String.length s)) ^ ":" ^ s
  and intercalate sep xs = 
    let rec intercalate_tr acc = function
      | [] -> acc
      | hd::[] -> acc ^ hd
      | hd::tl -> intercalate_tr (hd^sep) tl in
    intercalate_tr "" xs in
  let ids = (intercalate " " (map string_of_int r.ids)) in
  r.uuid ^ " " ^ (netstring_of_string ids) ^ ", " ^ r.body
