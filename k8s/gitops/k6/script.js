import http from 'k6/http';
import { check, sleep } from 'k6';

// test configurations
export const options = {
  vus: 50,
  duration: '5m',
};

export default function () {
  const payload = JSON.stringify({
    streams: [
      {
        stream: {
          app: 'k6-stress-test',
          env: 'test'
        },
        values: [
          [String(Date.now() * 1000000), `Log message to test Loki: ${Math.random()}`]
        ]
      }
    ]
  });

  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };

  const res = http.post('http://localhost:3100/loki/api/v1/push', payload, params);

  check(res, {
    'status is 204': (r) => r.status === 204,
  });

  sleep(0.1);
}