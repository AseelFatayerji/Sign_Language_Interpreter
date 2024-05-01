from kivymd.app import MDApp
from kivy.lang import Builder
from kivy.uix.boxlayout import BoxLayout
from kivy.core.window import Window

class NavBar(BoxLayout):
    pass
class SilentLearning(MDApp):

    def build(self):
        Window.size = (260, 500)
        self.theme_cls.theme_style = "Dark"
        self.theme_cls.primary_pallet = "#71D4CC"
        return Builder.load_file('components/navbar.kv')


if __name__ == '__main__':
    SilentLearning().run()