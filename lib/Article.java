import java.util.ArrayList;
import java.util.List;

public class Article {
    static {
        //List<Article> artList = new ArrayList<>();
        Article art1 = new Article("Viande de boeuf");
        Article art2 = new Article("Poisson");
        Article art3 = new Article("Plastique");
        Article art4 = new Article("Déplacement");
        Article.artList.add(art1);
        Article.artList.add(art2);
        Article.artList.add(art3);
        Article.artList.add(art4);
    }

    private String label;
    static List<Article> artList = new ArrayList<>();

    public Article() {
    }
    public Article(String label) {
        this.label = label;
    }

    public String getLabel() {
        return this.label;
    }

    public void setLabel(String label){
        this.label = label;
    }

    public static List<Article> getArtList() {
        return Article.artList;
    }
}
