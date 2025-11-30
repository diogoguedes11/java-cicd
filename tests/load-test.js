import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 10, // Ten virtual users
  duration: '30s', // For 30 seconds
  thresholds: {
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<500'],
  },
};

export default function () {
  // pass as a env variable the service URL if needed
  const url = __ENV.TARGET_URL || 'http://localhost:8085/actuator/health';
  console.log(`Testing URL: ${url}`);
  const res = http.get(url);
  // Validation
  check(res, {
    'status is 200': (r) => r.status === 200,
  });

  sleep(1);
}