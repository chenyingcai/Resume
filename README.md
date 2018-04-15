# Resume 简历主题
---

本主题是基于[zresume](https://github.com/izuolan/zresume) 和 [Fernando Báez](https://github.com/getgrav/grav-theme-resume) 的模板生成的

直接使用`/bin/bash start.sh` 或者运行`curl https://raw.githubusercontent.com/chenyingcai/Resume/master/start.sh | bash` , 其会自动检查是否有相应的docker image 然后自行安装

# bug:
交替使用以下命令, 先generate然后run, 最后打开localhost:\[你之前输入的port\] (默认是8080,可以通过/bin/bash start.sh 9000更改为9000或其他)
## `generate:`

```sh
docker exec resume generate # 如果正常你会看到产生一个index.html, 在static中可见
```

## run:

```sh
docker exec resume run # 打开网页localhost:[你之前输入的port] 查看
```

## 提示:

要将修改完的文件发布之前, 最好是先执行上面generate描述的代码, 然后上传static里面的内容即可
