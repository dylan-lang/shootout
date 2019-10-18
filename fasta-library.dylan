module: dylan-user

define library fasta
  use common-dylan;
  use io;
end library;

define module fasta
  use common-dylan, exclude: { format-to-string };
  use standard-io;
  use streams;
  use format-out;
end module;
