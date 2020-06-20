import redis.clients.jedis.Jedis;

public class RedisDemo {
    static Jedis jedis=new Jedis("192.168.192.128",6379);

    public static void main(String args[]) {
        testCheckLogin();
    }
    public static void testCheckLogin() {
        //登录验证时，5分钟内连续输错3次密码，锁住帐号;帐号锁住时间为半个小时，半小时后解封
        jedis.auth("123456");
        checkUser("18217272828", "123456");
    }

    private static void checkUser(String loginId, String password) {
        Boolean exit = jedis.exists(loginId);

        if (exit == true && ("true".equals(jedis.get(loginId)))) {
            System.out.println("该帐号已被锁，请确认");
            //            throw new CommonBizException("该帐号已被锁，请确认");

        } else if (exit == true && "3".equals(jedis.get(loginId))) {
            //锁帐号
            jedis.set(loginId, "true");
            //设置半个小时的过期时间
            jedis.expire(loginId, 20 * 60);
        } else {
            checkNameAndPassword("18217272828", "123");
        }
    }
    private static void checkNameAndPassword(String loginId, String password) {

        if ("18217272828".equals(loginId) && "123456".equals(password)) {
            jedis.del(loginId);
            System.out.println("登录成功");

        } else {
            if (jedis.exists(loginId)) {
                jedis.incr(loginId);
            } else {
                jedis.setex(loginId, 300, "1");
            }
            System.out.println("第" + jedis.get(loginId) + "密码错误，登录失败");
        }

    }

}
