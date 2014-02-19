open List
open Mongrel2Response
open Printf

type http_response = {
  code: int;
  status: string;
  headers: (string * string) list;
  body: string
}

let mongrel2_response_of_http_response (uuid: string) (ids: int list)
    (r: http_response): mongrel2_response =
  let headers = 
    String.concat "\r\n" (map (fun (k,v) -> sprintf "%s:%s" k v) r.headers)  in
  let mongrel2_response_body =
    sprintf "HTTP/1.1 %i %s\r\n%s\r\n\r\n%s" r.code r.status headers r.body in
  { uuid = uuid;
    ids = ids;
    Mongrel2Response.body = mongrel2_response_body }
