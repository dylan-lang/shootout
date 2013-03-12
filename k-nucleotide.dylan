module: k-nucleotide

define library k-nucleotide
  use common-dylan;
  use io;
end library;

define module k-nucleotide
  use common-dylan, exclude: { format-to-string };
  use format-out;
  use standard-io;
  use streams;
end module;


define sealed class <key-value-pair> (<object>)
  constant slot key :: <string>, required-init-keyword: key:;
  slot val :: <integer>, required-init-keyword: value:;
end class <key-value-pair>;

define sealed domain make(singleton(<key-value-pair>));
define sealed domain initialize(<key-value-pair>);


define function kfrequency
    (sequence :: <string>,
     freq :: <string-table>,
     k :: <integer>,
     frame :: <integer>) => ();
  for (i from frame below sequence.size - k + 1 by k)
    let sub = make(<string>, size: k);
    for (offset from 0 below k) sub[offset] := sequence[i + offset] end;
    let record = element(freq, sub, default: #f);
    if (record)
      record.val := record.val + 1;
    else
      freq[sub] := make(<key-value-pair>, key: sub, value: 1);
    end if;
  end for;
end function kfrequency;


define function frequency(sequence :: <string>, k :: <integer>)
  let freq = make(<string-table>);
  for (i from 0 below k)
    kfrequency(sequence, freq, k, i);
  end for;

  let sorted = sort(as(<vector>, freq),
                    test: method (a :: <key-value-pair>,
                                  b :: <key-value-pair>) b.val < a.val end);
  let sum = reduce(\+, 0, map(val, sorted));

  for (kvp in sorted)
    // FIXME: "%.3f" is not supported as control-string, as a result 7 decimal
    // digits and 'd' marker is printed, instead of 3 decimal digits without
    // marker.
    //format-out("%s %.3f\n", kvp.key, kvp.val * 100.0d0 / sum);
    format-out("%s %=\n", kvp.key, kvp.val * 100.0d0 / sum);
  end for;
  format-out("\n");
end function frequency;


define function count (sequence :: <string>, fragment :: <string>)
  let freq = make(<string-table>);
  for (i from 0 below fragment.size)
    kfrequency(sequence, freq, fragment.size, i);
  end for;
  let record = element(freq, fragment, default: #f);
  format-out("%d\t%s\n", record & record.val | 0, fragment);
end function count;


begin
  let chars = make(<stretchy-object-vector>);

  block ()
    for (line :: <string> = read-line(*standard-input*)
           then read-line(*standard-input*),
         until: line[0] == '>' & copy-sequence(line,start: 1, end: 6) = "THREE")
    end;
    for (line :: <string> = read-line(*standard-input*)
           then read-line(*standard-input*),
         until: line[0] == '>')
      if (line[0] ~== ';')
        let old-size = chars.size;
        chars.size := old-size + line.size;
        for (ch in line, i from old-size)
          chars[i] := as-uppercase(ch);
        end;
      end if;
    end for;
  exception (e :: <end-of-stream-error>)
  end;

  let sequence = as(<string>, chars);
  
  frequency(sequence, 1);
  frequency(sequence, 2);

  count(sequence, "GGT");
  count(sequence, "GGTA");
  count(sequence, "GGTATT");
  count(sequence, "GGTATTTTAATT");
  count(sequence, "GGTATTTTAATTTATAGT");
end;
