export default function Home() {
  return (
    <main style={{ padding: 24, fontFamily: 'system-ui' }}>
      <h1>Next.js Hello (containerized)</h1>
      <p>This app Running in Minikube</p>
      <p>Health: <code>/api/health</code></p>
    </main>
  )
}
