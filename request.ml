open Str
open String

type request = {
  uuid: string;
  id: int;
  path: string;
  headers: (string * string) list;
  body: string }

let read_request request =
  let split_at i s = 
    if succ i > length s then
      (s, "")
    else if succ i = length s then
      (string_before s i, "")
    else 
      (string_before s i, string_after s (succ i)) in
  let split_at_char c s = split_at (index s c) s in
  let split_at_space = split_at_char ' '
  and split_at_colon = split_at_char ':' in
  let split_netstring s =
    let (length, rest) = split_at_colon s in
    split_at (int_of_string length) rest in
  let read_headers s =
    let unwrap1 s = sub s 1 (length s - 2) in
    let remove_brackets = unwrap1
    and remove_quotes = unwrap1
    and chomp_regexp_string r s =
      if (string_match (regexp r) s 0) then
	 split_at (match_end ()) s
      else
	("", s) in
    let chomp_string = 
      chomp_regexp_string "\"\\([^\"]*\\(\\\\[\"]\\)?\\)*\"" in
    let rec read_headers_tr acc s =
      if length s <> 0 then
	let (k, s') = chomp_string s in
	let (v, s'') = chomp_string s' in
	read_headers_tr ((remove_quotes k, remove_quotes v)::acc) s''
      else
	acc in
    read_headers_tr [] (remove_brackets s) in
  let split_uuid = split_at_space
  and split_id = split_at_space
  and split_path = split_at_space in
  let (uuid, request') = split_uuid request in
  let (id, request') = split_id request' in
  let (path, request') = split_path request' in
  let (headers, request') = split_netstring request' in
  let (body, _) = split_netstring request' in
  { uuid = uuid;
    id = int_of_string id;
    path = path;
    headers = read_headers headers;
    body = body }



(*

let r = regexp

let ctxt = init 1
let pull = socket ctxt PULL

let ws = "[ \t]+"
let number = "\\([0-9]+\\)"
let process_request s =
  let chomp s i = string_before i
  let rec process_request = function
    | `UUID -> fun s ->
      let delim = index s ' ' in
      let (uuid, rest) = (string_before s delim, string_after s delim) in
      (`UUID, uuid)::(process_request `ID rest)
    | `ID -> fun s ->
      let delim = index s ' ' in
      let (uuid, rest) = (string_before s delim, string_after s delim) in
      (`UUID, uuid)::(process_request `HEADERS rest)

let uuid = "\\([a-z]\\|[A-Z]\\|[0-9]\\|[-]\\)+"
let id = number
let path = "\\([^ ]+\\)" (* Obviously context-sensitive *)
let size = number
let headers = "{"

*)
