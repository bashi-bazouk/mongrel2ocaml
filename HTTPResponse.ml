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
    let headers = 
      if mem_assoc "Content-Length" r.headers then
	r.headers
      else
	let content_length = string_of_int (String.length r.body) in
	("Content-Length", content_length)::r.headers in
    String.concat "\r\n" (map (fun (k,v) -> sprintf "%s: %s" k v) headers)  in
  let mongrel2_response_body =
    sprintf "HTTP/1.1 %i %s\r\n%s\r\n\r\n%s" r.code r.status headers r.body in
  { uuid = uuid;
    ids = ids;
    Mongrel2Response.body = mongrel2_response_body }

let okay = {
  code = 200;
  status = "OKAY";
  headers = [];
  body = "" }

let not_found = {
  code = 404;
  status = "Not Found";
  headers = [];
  body = "" }

let internal_server_error = {
  code = 500;
  status = "Internal Server Error";
  headers = [];
  body = "" }

let not_implemented = {
  code = 501;
  status = "Not Implemented";
  headers = [];
  body = "" }
