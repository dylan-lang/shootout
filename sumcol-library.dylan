module: dylan-user

define library sumcol
  use common-dylan;
  use io;
end library;

define module sumcol
  use common-dylan, exclude: { format-to-string };
  use format-out;
  use standard-io;
  use streams;
end module;
