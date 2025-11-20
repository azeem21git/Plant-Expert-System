document.getElementById('plantForm').addEventListener('submit', async (e) => {
  e.preventDefault();

  const watering = document.getElementById('watering').value;
  const lighting = document.getElementById('lighting').value;
  const toxicity = document.getElementById('toxicity').value;
  const ease = document.getElementById('ease').value;

  try {
    const url = new URL('/recommend', window.location.origin);
    url.searchParams.append('watering', watering);
    url.searchParams.append('lighting', lighting);
    url.searchParams.append('toxicity', toxicity);
    url.searchParams.append('ease', ease);

    const res = await fetch(url);
    if (!res.ok) {
      throw new Error('Server response was not ok');
    }
    const data = await res.json();

    document.getElementById('result').innerText = "🌼 Recommended Plant: " + data.recommendation;
  } catch (error) {
    console.error('Error:', error);
    document.getElementById('result').innerText = "❌ Error: Could not get plant recommendation";
  }
});

