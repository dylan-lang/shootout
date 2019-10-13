module: dylan-user

define library reversefile
  use common-dylan;
  use io;
end library;

define module reversefile
  use common-dylan, exclude: { format-to-string };
  use standard-io;
  use streams;
end module;
