# Getting Meeting Transcripts

## Recommended File Naming

Use `YYYY-MM-DD - Meeting Name.txt` format for consistent date sorting:
```
2026-03-10 - Weekly Standup.txt
2026-03-12 - 1:1 with Marcus.vtt
2026-03-19 - Q1 Product Review.md
```

## Export Sources

### Granola (free with Lenny's newsletter)
- Granola auto-transcribes meetings running on your Mac
- Open Granola → Select a meeting → Export as Markdown
- Exports include speaker labels and timestamps

### Zoom
- Enable cloud recording with transcription in Zoom settings
- After each meeting: Recordings → Download → `.vtt` transcript file
- For bulk export: Zoom web portal → Reports → Cloud Recordings

### Google Meet
- Use the Meet transcript feature (requires Workspace admin to enable)
- Transcripts appear in Google Docs in your Drive after the meeting
- Download as `.txt` from Google Docs

### Fireflies.ai / Otter.ai
- Both services offer bulk export
- Export folder: Settings → Export → Download All Transcripts
- Choose `.txt` or `.srt` format

## Privacy

Keep sensitive meeting transcripts local. This skill reads files on your machine — nothing is sent externally beyond what Claude normally processes.

## Best Practices

1. **Keep transcripts in one folder** — point the skill at the whole folder
2. **Include speaker labels** — the skill identifies your contributions via your name or a consistent speaker label
3. **Analyze regularly** — monthly or quarterly reviews surface trends you'd miss meeting-by-meeting
4. **One focus at a time** — ask about one behavior (e.g., conflict avoidance) per run for deeper examples
