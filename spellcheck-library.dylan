module: dylan-user

define library spellcheck
  use common-dylan;
  use collections;
  use io;
  use system;
end library;

define module spellcheck
  use common-dylan, exclude: { format-to-string };
  use file-system;
  use table-extensions;
  use format-out;
  use standard-io;
  use streams;
end module;
