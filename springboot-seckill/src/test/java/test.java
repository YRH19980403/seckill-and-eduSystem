import org.junit.Test;
import redis.clients.jedis.BasicCommands;
import redis.clients.jedis.BinaryJedis;
import redis.clients.jedis.Jedis;

class RedisTest {
  Jedis jedis = new Jedis("192.168.192.128", 6379);


    public  void testCheckLogin() {
                //登录验证时，连续输错3次密码，锁住帐号;帐号锁住时间为20分钟，20分钟后解封

                checkUser("18718185897", "12356");
            }

            private  void checkUser(String loginId, String password) {
                 Boolean exit = jedis.exists(loginId);

                 if (exit == true && ("true".equals(jedis.get(loginId)))) {
                        System.out.println("该帐号密码错误超过3次，已被锁定！");
                     // throw new CommonBizException("该帐号已被锁，请确认");

                     } else if (exit == true && "3".equals(jedis.get(loginId))) {
                        //锁帐号
                         jedis.set(loginId, "true");//设置20分钟的过期时间
                         jedis.expire(loginId, 20 * 60);
                    } else {
                         checkNameAndPassword("18718185897", "12356");
                    }
            }

            private  void checkNameAndPassword(String loginId, String password) {

                 if ("18718185897".equals(loginId) && "123456".equals(password)) {
                        jedis.del(loginId);
                        System.out.println("登录成功");

                    } else {
                        if (jedis.exists(loginId)) {
                                 jedis.incr(loginId);
                            } else {
                                jedis.setex(loginId, 300, "1");
                            }
                         System.out.println("第" + jedis.get(loginId) + "登录失败");
                     }

             }

         }
