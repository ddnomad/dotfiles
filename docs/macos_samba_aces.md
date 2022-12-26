TODO: Cleanup

```
#!/bin/zsh

chmod -R +a "group:data_sharing_1 allow readsecurity,readattr,readextattr,list,search,read,execute,writeattr,writeextattr,delete,add_file,add_subdirectory,delete_child,write,append,file_inherit,directory_inherit" /Volumes/Data
chmod -R +a "group:data_sharing_2 allow readsecurity,readattr,readextattr,list,search,read,execute,writeattr,writeextattr,delete,add_file,add_subdirectory,delete_child,write,append,file_inherit,directory_inherit" /Volumes/Data/Downloads

chmod -R +a "group:data_sharing_2 allow readsecurity,readattr,readextattr,list,search,read,execute,writeattr,writeextattr,delete,add_file,add_subdirectory,delete_child,write,append,file_inherit,directory_inherit" /Volumes/Media
```
