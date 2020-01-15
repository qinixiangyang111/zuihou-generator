# @xxx@ 从pom.xml中取值, 所以 @xx@ 标注的值，都不能从nacos中获取
zuihou:
  nacos:
    ip: ${r"${"}NACOS_IP:@pom.nacos.ip@${r"}"}
    port: ${r"${"}NACOS_PORT:@pom.nacos.port@${r"}"}
    namespace: ${r"${"}NACOS_ID:@pom.nacos.namespace@${r"}"}

spring:
  main:
    allow-bean-definition-overriding: true
  application:
    name: @project.artifactId@
  profiles:
    active: @pom.profile.name@
  cloud:
    nacos:
      config:
        server-addr: ${r"${"}zuihou.nacos.ip${r"}"}:${r"${"}zuihou.nacos.port${r"}"}
        file-extension: yml
        namespace: ${r"${"}zuihou.nacos.namespace${r"}"}
        #支持多个共享 Data Id 的配置，多个之间用逗号隔开,多个共享配置间的一个优先级的关系我们约定：按照配置出现的先后顺序，即后面的优先级要高于前面
        #Data Id 必须带文件扩展名，文件扩展名既可支持 properties，也可以支持 yaml/yml。 此时 spring.cloud.nacos.config.file-extension 的配置对自定义扩展配置的 Data Id 文件扩展名没有影响。
        shared-dataids: common.yml,redis.yml,mysql.yml,rabbitmq.yml
        #支持哪些共享配置的 Data Id 在配置变化时，应用中是否可动态刷新， 感知到最新的配置值，多个 Data Id 之间用逗号隔开。如果没有明确配置，默认情况下所有共享配置的 Data Id 都不支持动态刷新。‘
        refreshable-dataids: common.yml
        enabled: true
      discovery:
        server-addr: ${r"${"}zuihou.nacos.ip}:${r"${"}zuihou.nacos.port${r"}"}
        namespace: ${r"${"}zuihou.nacos.namespace${r"}"}
        metadata: # 元数据，用于权限服务实时获取各个服务的所有接口
          management.context-path: ${r"${"}server.servlet.context-path:${r"}"}${r"${"}spring.mvc.servlet.path:${r"}"}${r"${"}management.endpoints.web.base-path:${r"}"}
  aop:
    proxy-target-class: true
    auto: true

# 只能配置在bootstrap.yml ，否则会生成 log.path_IS_UNDEFINED 文件夹
# window会自动在 代码所在盘 根目录下自动创建文件夹，  如： D:/data/projects/logs
logging:
  file:
    path: /data/projects/logs
    name: ${r"${"}logging.file.path${r"}"}/${r"${"}spring.application.name}/root.log

# 用于/actuator/info
info:
  name: '@project.name@'
  description: '@project.description@'
  version: '@project.version@'
  spring-boot-version: '@spring.boot.version@'
  spring-cloud-version: '@spring.cloud.version@'
