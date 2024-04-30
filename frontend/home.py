from kivymd.app import MDApp
from kivy.lang import Builder
from kivy.uix.boxlayout import BoxLayout
# import kivysome
# kivysome.enable( "https://kit.fontawesome.com/3466402afb.js", group=kivysome.FontGroup.REGULAR)
class NavBar(BoxLayout):
    pass
class SilentLearning(MDApp):

    def build(self):
        return Builder.load_file('components/navbar.kv')


if __name__ == '__main__':
    SilentLearning().run()