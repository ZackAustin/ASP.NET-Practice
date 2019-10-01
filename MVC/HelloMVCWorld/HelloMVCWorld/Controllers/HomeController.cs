using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace HelloMVCWorld.Controllers
{
    public class HomeController : Controller
    {
        // GET: /<controller>/
        public IActionResult Index()
        {
            Models.Movie movie = new Models.Movie()
            {
                Title = "The Godfather",
                ReleaseDate = new DateTime(1972, 3, 24)
            };
            //Until we get to routing.
            //return RedirectToAction("Details");
            return View(movie);
        }

        [HttpGet]
        public IActionResult Edit()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Edit(Models.Movie movie)
        {
            return Content("Movie updated!");
        }

        public IActionResult Details(int id)
        {
            ViewData["ProductTitle"] = "Toiler Paper";
            ViewBag.ProductPrice = 1.99;
            return View();
        }
    }
}
