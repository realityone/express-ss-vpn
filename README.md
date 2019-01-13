# express-ss-vpn
Share your ExpressVPN as shad0wsocks.

## Usage

Simplify using `docker-compose up -d` is enough to setup your service.

### Activate

```shell
root@jp:~/express-ss-vpn# docker-compose exec vpn expressvpn activate
Enter activation code: 
Activated.
Help improve ExpressVPN: Share crash reports, speed tests, and whether VPN connection attempts succeed. These reports never contain personally identifiable information. (Y/n) n
root@jp:~/express-ss-vpn# docker-compose restart
Restarting expressssvpn_vpn_1 ... done
```

### Connect to other region

Change `VPN_LOCATION` environment variable and re-deploy with docker-compose.

### License

[GLWTPL](https://github.com/me-shaon/GLWTPL)