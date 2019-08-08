Prerequisite - create a key pair and put it in terraform vars - can be automated, but well, a bit easier.

# ECS with ALB example

This example shows how to launch an ECS service fronted with Application Load Balancer.

The example uses latest CoreOS Stable AMIs.

All in all it sets up all infra needed to minimal run of simple nodejs app (with some overkill with adding already db subnets if needed)

On final step of apply as an output there will be a DNS name of alb - it should point to nginx container, served by ecs - it may be easily switched to anything, so pretty much - working infra.

## Get up and running
Init phase - go to `tf-state-inialization` and run init.sh 

Planning phase

```
bash plan.sh
```

Apply phase

```
bash apply.sh
```

Once the stack is created, wait for a few minutes and test the stack by launching a browser with the ALB url.

## Destroy :boom:

```
bash destroy.sh
```


