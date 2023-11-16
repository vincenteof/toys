# how it works
blob 是存储的是文件内容
tree 存储的是当前目录结构的 snapshot，它包含 blob
一旦有了对应的 SHA-1，我们总能拿到对应的内容
commit 则是 tree (snapshot) 和一些附加信息，比如 message 的集合
commit 是有时间线的，因此生存 commit 的时候需要有上一个 commit 的 SHA-1
因此只要能拿到最新一个 commit 的 SHA，我们自然也能知道它的所有历史，只要不断往上找 parent 即可
blob，tree 以及 commit 会形成一个 DAG
ref 比较简单，它是一个用简单名字存储 SHA 的文件，一般它指向某个分支的最新 commit
HEAD 始终指向你当前分支的最新 commit，它是一个符号链接，一般来说直接指向某个 ref



# 参考
https://zhuanlan.zhihu.com/p/93950349
https://git-scm.com/book/en/v2/Git-Internals-Git-Objects
https://git-scm.com/book/en/v2/Git-Internals-Git-References
https://git-scm.com/book/en/v2/Git-Internals-Packfiles
https://konrad126.medium.com/understanding-git-index-4821a0765cf
https://youtu.be/4XpnKHJAok8
https://youtu.be/bSA91XTzeuA
