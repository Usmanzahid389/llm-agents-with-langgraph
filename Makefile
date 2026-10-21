ENV_NAME ?= ai-agents

.PHONY: setup notebook-setup lock agent test

# Install everything (root deps + demos/research_agent) into .venv
setup:
	uv sync

# Register the Jupyter kernel used by the notebooks
notebook-setup:
	uv run python -m ipykernel install --user --name=$(ENV_NAME) --display-name "AI Agents ($(ENV_NAME))"

# After editing pyproject.toml by hand: re-lock and install
lock:
	uv lock
	uv sync

# Run the research agent dev server (LangGraph Studio)
agent:
	cd demos/research_agent && uv run langgraph dev --no-reload

# Smoke tests — needs `make agent` running in another terminal
test:
	cd demos/research_agent && uv run pytest tests/
