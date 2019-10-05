using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace HelloMVCWorld.Controllers
{
    [Route("/Products")]
    public class ProductsController : Controller
    {
        [Route("Index")]
        [Route("")]
        public IActionResult Index()
        {
            return Content("Product overview");
        }

        [Route("List")]
        public IActionResult List()
        {
            return View();
        }

        [Route("Details/{id?}")]
        [Route("/Product/Details/{id?}")]
        public IActionResult Details(int id)
        {
            return Content("Product details for #" + id);
        }
    }
}