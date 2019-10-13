module: dylan-user

define library wc
  use common-dylan;
  use io;
end library;

define module wc
  use common-dylan, exclude: { format-to-string };
  use format-out;
  use standard-io;
  use streams;
end module;
