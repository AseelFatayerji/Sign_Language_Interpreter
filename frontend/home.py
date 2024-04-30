import kivy
from kivy.app import App
from kivy.lang import Builder
# import kivysome
# kivysome.enable( "https://kit.fontawesome.com/3466402afb.js", group=kivysome.FontGroup.REGULAR)

class MyApp(App):

    def build(self):
        return Builder.load_file('components/bbar.kv')


if __name__ == '__main__':
    MyApp().run()