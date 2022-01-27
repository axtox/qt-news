using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System.Xml.Linq;
using System.Xml.XPath;
using core_qt.Model.News;

namespace core_qt.ViewModel {
    public class MainViewModel {
        public DateTime Time {get;set;}
        public List<News> News {get; private set;}

        public MainViewModel() {
            Time = new DateTime();
            News = new List<News>();
        }

        public async Task<List<News>> Getnews() {

            var xmlNewsSource = await new HttpClient().GetStringAsync("https://lenta.ru/rss/last24");
            XDocument xmlNewsDocument = XDocument.Parse(xmlNewsSource);
            var allXmlNews = xmlNewsDocument.XPathSelectElements("//item");

            foreach(var xmlNews in allXmlNews) {
                News.Add(new News() { 
                    Title = xmlNews.XPathSelectElement("title").Value, 
                    Description = xmlNews.XPathSelectElement("description").Value,
                    PublicationDate = DateTime.Parse(xmlNews.XPathSelectElement("pubDate").Value),
                    Link = xmlNews.XPathSelectElement("link").Value,
                    Image = xmlNews.XPathSelectElement("enclosure").Attribute("url").Value
                });
            }

            return News;
        }

    }
}