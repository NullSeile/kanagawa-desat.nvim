local c = require("kanagawa-desat.lib.color")

local function sat(hex, s)
    return c(hex):saturate(s):to_hex()
end

local function bright(hex, b)
    return c(hex):brighten(b):to_hex()
end

local function bg(hex)
    return sat(bright(hex, 0.042), -1.)
end

local function fg(hex)
    return hex
    -- return sat(hex, 0.1)
end

local function id(hex)
    return hex
    -- return sat(hex, 0)
end

---@class PaletteColors
local palette = {

    -- Bg Shade
    sumiInk0 = bg("#16161D"),
    sumiInk1 = bg("#181820"),
    sumiInk2 = bg("#1a1a22"),
    sumiInk3 = bg("#1F1F28"),
    sumiInk4 = bg("#2A2A37"),
    sumiInk5 = bg("#363646"),
    sumiInk6 = bg("#54546D"), --fg

    -- Popup and Floats
    waveBlue1 = bg("#223249"),
    waveBlue2 = bg("#2D4F67"),

    -- Diff and Git
    winterGreen = fg("#2B3328"),
    winterYellow = fg("#49443C"),
    winterRed = fg("#43242B"),
    winterBlue = fg("#252535"),
    autumnGreen = fg("#76946A"),
    autumnRed = fg("#C34043"),
    autumnYellow = fg("#DCA561"),

    -- Diag
    samuraiRed = fg("#E82424"),
    roninYellow = fg("#FF9E3B"),
    waveAqua1 = fg("#6A9589"),
    dragonBlue = fg("#658594"),

    -- Fg and Comments
    oldWhite = id("#C8C093"),
    fujiWhite = id("#DCD7BA"),
    fujiGray = id("#727169"),

    oniViolet = fg("#957FB8"),
    oniViolet2 = fg("#b8b4d0"),
    crystalBlue = fg("#7E9CD8"),
    springViolet1 = fg("#938AA9"),
    springViolet2 = fg("#9CABCA"),
    springBlue = fg("#7FB4CA"),
    lightBlue = fg("#A3D4D5"), -- unused yet
    waveAqua2 = fg("#7AA89F"), -- improve lightness: desaturated greenish Aqua

    -- waveAqua2  = "#68AD99",
    -- waveAqua4  = "#7AA880",
    -- waveAqua5  = "#6CAF95",
    -- waveAqua3  = "#68AD99",

    springGreen = fg("#98BB6C"),
    boatYellow1 = fg("#938056"),
    boatYellow2 = fg("#C0A36E"),
    carpYellow = fg("#E6C384"),

    sakuraPink = fg("#D27E99"),
    waveRed = fg("#E46876"),
    peachRed = fg("#FF5D62"),
    surimiOrange = fg("#FFA066"),
    katanaGray = fg("#717C7C"),

    dragonBlack0 = "#0d0c0c",
    dragonBlack1 = "#12120f",
    dragonBlack2 = "#1D1C19",
    dragonBlack3 = "#181616",
    dragonBlack4 = "#282727",
    dragonBlack5 = "#393836",
    dragonBlack6 = "#625e5a",

    dragonWhite = "#c5c9c5",
    dragonGreen = "#87a987",
    dragonGreen2 = "#8a9a7b",
    dragonPink = "#a292a3",
    dragonOrange = "#b6927b",
    dragonOrange2 = "#b98d7b",
    dragonGray = "#a6a69c",
    dragonGray2 = "#9e9b93",
    dragonGray3 = "#7a8382",
    dragonBlue2 = "#8ba4b0",
    dragonViolet = "#8992a7",
    dragonRed = "#c4746e",
    dragonAqua = "#8ea4a2",
    dragonAsh = "#737c73",
    dragonTeal = "#949fb5",
    dragonYellow = "#c4b28a", --"#a99c8b",
    -- "#8a9aa3",

    lotusInk1 = "#545464",
    lotusInk2 = "#43436c",
    lotusGray = "#dcd7ba",
    lotusGray2 = "#716e61",
    lotusGray3 = "#8a8980",
    lotusWhite0 = "#d5cea3",
    lotusWhite1 = "#dcd5ac",
    lotusWhite2 = "#e5ddb0",
    lotusWhite3 = "#f2ecbc",
    lotusWhite4 = "#e7dba0",
    lotusWhite5 = "#e4d794",
    lotusViolet1 = "#a09cac",
    lotusViolet2 = "#766b90",
    lotusViolet3 = "#c9cbd1",
    lotusViolet4 = "#624c83",
    lotusBlue1 = "#c7d7e0",
    lotusBlue2 = "#b5cbd2",
    lotusBlue3 = "#9fb5c9",
    lotusBlue4 = "#4d699b",
    lotusBlue5 = "#5d57a3",
    lotusGreen = "#6f894e",
    lotusGreen2 = "#6e915f",
    lotusGreen3 = "#b7d0ae",
    lotusPink = "#b35b79",
    lotusOrange = "#cc6d00",
    lotusOrange2 = "#e98a00",
    lotusYellow = "#77713f",
    lotusYellow2 = "#836f4a",
    lotusYellow3 = "#de9800",
    lotusYellow4 = "#f9d791",
    lotusRed = "#c84053",
    lotusRed2 = "#d7474b",
    lotusRed3 = "#e82424",
    lotusRed4 = "#d9a594",
    lotusAqua = "#597b75",
    lotusAqua2 = "#5e857a",
    lotusTeal1 = "#4e8ca2",
    lotusTeal2 = "#6693bf",
    lotusTeal3 = "#5a7785",
    lotusCyan = "#d7e3d8",
}

local function dump(o)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            -- if type(k) ~= "number" then
            --     k = '"' .. k .. '"'
            -- end
            s = s .. k .. " = " .. dump(v) .. ","
        end
        return s .. "} "
    elseif type(o) == "string" then
        return '"' .. o .. '"'
    else
        return tostring(o)
    end
end

-- vim.notify(dump(palette))

local M = {}
--- Generate colors table:
--- * opts:
---   - colors: Table of personalized colors and/or overrides of existing ones.
---     Defaults to KanagawaConfig.colors.
---   - theme: Use selected theme. Defaults to KanagawaConfig.theme
---     according to the value of 'background' option.
---@param opts? { colors?: table, theme?: string }
---@return { theme: ThemeColors, palette: PaletteColors}
function M.setup(opts)
    opts = opts or {}
    local override_colors = opts.colors or require("kanagawa-desat").config.colors
    -- local theme = opts.theme or require("kanagawa")._CURRENT_THEME -- WARN: this fails if called before kanagawa.load()
    local theme = "desat"

    if not theme then
        error(
            "kanagawa.colors.setup(): Unable to infer `theme`. Either specify a theme or call this function after ':colorscheme kanagawa'"
        )
    end

    -- Add to and/or override palette_colors
    local updated_palette_colors = vim.tbl_extend("force", palette, override_colors.palette or {})

    -- Generate the theme according to the updated palette colors
    local theme_colors = require("kanagawa-desat.themes")[theme](updated_palette_colors)

    -- Add to and/or override theme_colors
    local theme_overrides =
        vim.tbl_deep_extend("force", override_colors.theme["all"] or {}, override_colors.theme[theme] or {})
    local updated_theme_colors = vim.tbl_deep_extend("force", theme_colors, theme_overrides)
    -- return palette_colors AND theme_colors

    return {
        theme = updated_theme_colors,
        palette = updated_palette_colors,
    }
end

return M
