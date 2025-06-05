import catppuccin

# load your autoconfig
config.load_autoconfig()

# theme
catppuccin.setup(c, 'mocha', True)

c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = False
c.auto_save.session = True

# font 
c.fonts.default_family = "IntoneMono Nerd Font Propo"
# c.content.user_stylesheets = [ "./css/font.css" ]

# try to block some sites 
c.content.blocking.method = 'both'

# new binding
config.bind('t', 'cmd-set-text -s :open -t')
config.bind('b', 'cmd-set-text -s :tab-focus')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('<Esc>', 'mode-leave;;fake-key <Esc>', mode='insert')
