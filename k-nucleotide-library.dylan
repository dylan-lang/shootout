module: dylan-user

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
