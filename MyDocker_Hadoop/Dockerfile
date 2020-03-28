FROM centos:7
MAINTAINER Zhangqx  zhangqx@ss.pku.edu.cn

LABEL Discription="hadoop base of centos7" version="1.0"

#安装必备的软件包
RUN yum -y install net-tools
RUN yum -y install which
RUN yum -y install openssh-server openssh-clients
RUN yum clean all


#配置SSH免密登录
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -q -t dsa -f /etc/ssh/ssh_host_ed25519_key  -N ''
RUN ssh-keygen -f /root/.ssh/id_rsa -N ''
RUN touch /root/.ssh/authorized_keys
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN echo "root:ss123456" | chpasswd
COPY ./configs/ssh_config /etc/ssh/ssh_config

#添加JDK 增加JAVA_HOME环境变量
ADD ./tools/jdk-8u212-linux-x64.tar.gz /usr/local/
ENV JAVA_HOME /usr/local/jdk1.8.0_212/
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

#添加Hadoop并设置环境变量
ADD ./tools/hadoop-2.8.5.tar.gz /usr/local
ENV HADOOP_HOME /usr/local/hadoop-2.8.5

#将环境变量添加到系统变量中
ENV PATH $HADOOP_HOME/bin:$JAVA_HOME/bin:$PATH

#拷贝Hadoop相关的配置文件到镜像中
COPY ./configs/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh
COPY ./configs/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
COPY ./configs/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
COPY ./configs/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
COPY ./configs/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
COPY ./configs/master $HADOOP_HOME/etc/hadoop/master
COPY ./configs/slaves $HADOOP_HOME/etc/hadoop/slaves
COPY ./script/start-hadoop.sh $HADOOP_HOME/start-hadoop.sh
COPY ./script/restart-hadoop.sh $HADOOP_HOME/restart-hadoop.sh

#增加执行权限
RUN chmod 700 $HADOOP_HOME/start-hadoop.sh
RUN chmod 700 $HADOOP_HOME/restart-hadoop.sh

#创建数据目录
RUN mkdir -p /data/hadoop/dfs/data && \
    mkdir -p /data/hadoop/dfs/name && \
    mkdir -p /data/hadoop/tmp 

#开启SSH 22 端口
EXPOSE 22

#启动容器时执行的脚本文件
CMD ["/usr/sbin/sshd","-D"]

