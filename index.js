const express = require('express');
const app = express();

app.use(express.json());

function evaluateDrift(count) {
  let severity_label = "STABLE";
  let severity_level = 0;
  let stop_authority = false;

  if (count >= 3) {
    severity_label = "CRITICAL";
    severity_level = 2;
    stop_authority = true;
  } else if (count >= 1) {
    severity_label = "MEDIUM";
    severity_level = 1;
  }

  return {
    severity_label,
    severity_level,
    stop_authority
  };
}

app.post('/drift', (req, res) => {
  const { count } = req.body;

  if (typeof count !== 'number') {
    return res.status(400).json({ error: "Invalid input" });
  }

  const result = evaluateDrift(count);
  res.json(result);
});

app.listen(3000, () => {
  console.log("Engine running on port 3000");
});
