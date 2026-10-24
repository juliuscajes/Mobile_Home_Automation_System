class ApiEndpoints {
  // Cloudflare Tunnel URL (remote) o local IP (home)
  static const String baseUrl = 'https://your-tunnel.trycloudflare.com';
  // static const String localUrl = 'http://192.168.1.100:5000';

  // Auth (Cloudflare)
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';
  static const String logout = '/api/auth/logout';
  static const String verifyToken = '/api/auth/verify';

  // Devices (Orange Pi local backend)
  static const String devices = '/api/devices';
  static const String deviceControl = '/api/devices/{id}/control';
  static const String deviceStatus = '/api/devices/{id}/status';

  // Zones
  static const String zones = '/api/zones';
  static const String zoneControl = '/api/zones/{id}/control';

  // Schedules
  static const String schedules = '/api/schedules';

  // Sensors
  static const String environment = '/api/sensors/environment';
  static const String power = '/api/sensors/power';
  static const String motion = '/api/sensors/motion';

  // Alerts & Logs
  static const String alerts = '/api/alerts';
  static const String logs = '/api/logs';
}
