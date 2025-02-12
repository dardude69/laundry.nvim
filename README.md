# Laundry (Neo)Vim

Don't use my shitty config -- get empowered! Make your own!
It's easier than modding Skyrim!

[This is the Blender Donut tutorial of NeoVim](https://www.youtube.com/watch?v=w7i4amO_zaE)

## Using Godot with Laundry Vim

### NeoVim Settings

Start NeoVim with an RPC server listening at on the `/tmp/godot.pipe` named Unix pipe.
Godot will connect to NeoVim through this server.

I alias the following as `godotvim` in my `.bashrc` to cut down on typing.

```bash
alias godotvim='nvim --listen /tmp/godot.pipe'
```

### Godot Settings

Change the Editor Settings of Godot as follows:

> Editor Settings > Text Editor > External
>
> Use External Editor: [x]
> Exec Path: `nvim`
> Exec Flags: `--server /tmp/godot.pipe --remote-send "<C-\><C-N>:n {file}<CR>:call cursor({line},{col})<CR>"`

This tells Godot where the RPC server of NeoVim is (`/tmp/godot.pipe`), and how to send it file open
commands.

### Sources

- <https://ericlathrop.com/2024/02/configuring-neovim-s-lsp-to-work-with-godot/>
- <https://www.reddit.com/r/neovim/comments/1c2bhcs/godotgdscript_in_neovim_with_lsp_and_debugging_in/?rdt=56754>

And if the LSP starts lagging again:
- <https://www.reddit.com/r/neovim/comments/oedk9z/help_getting_gdscript_to_work_with_nvimlsp/>

## Using Unity with Laundry Vim

### Guides I'm smushing together

- <https://spaceandtim.es/code/nvim_unity_setup/>
- <https://dzfrias.dev/blog/neovim-unity-setup/>

### Steps

1. Our LSP is [Omnisharp Roslyn](https://github.com/OmniSharp/omnisharp-roslyn)
2. As per the readme, we're using it with Mono
    - [the latest stable version available for Ubuntu](https://www.mono-project.com/download/stable/)
    - `sudo apt install mono-devel mono-complete`
