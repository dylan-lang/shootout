module: dylan-user

define library wordfreq
  use common-dylan;
  use io;
end library;

define module wordfreq
  use common-dylan, exclude: { format-to-string };
  use format-out;
  use standard-io;
  use streams;
end module;
