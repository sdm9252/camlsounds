
open Bitstring

 (* Midi file make_up:
    
16 bit words
<Header Chunk> = <chunk type> <length> <format> <ntrks> <division>
    0                   1                   2                   3   
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                       MThd (in ascii chars)                   |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |      number 6 (because thats how many chunks are in header)   |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |format (1 of 3 possibilitys)   |         number of tracks      | 
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |X|   Division                  |                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   Some notes:
   num tracks must be 1 or 0 for format 0 files

   The high bit for division (X) specifies 2 formats, one for metrical time, the other for time code based time like so:
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5    
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |0| ticks per quarter note      |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5    
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |1|  SMPTE      |ticks per frame|
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   further, there are 3 possible SMPTE formats:
   -24, -25, -29, -30. corresponding to standard time formats
   typical values for ticks per frame are 8, 10, 80, 100.
   example: bit resolution of thirty franm

 *)
                          

let getmidiheaderinfo pkt =
  match%bitstring pkt with
  | {| mthd : 32; chunks : 32; format : 16; numtracks : 16; division : 16 |} ->
      Printf.printf "format: %i \n" format;
      Printf.printf "number of tracks: %i \n" numtracks;
      Printf.printf "division: %X \n" division

let () = print_endline "Hello, World!"
