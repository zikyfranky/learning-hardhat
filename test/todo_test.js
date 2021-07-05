const { expect } = require("chai");

describe("TODO", function() {
  let todo;
  let admin, second, third, rest
  
  before(async ()=> {
    [admin, second, third, ...rest] = await ethers.getSigners()
    const Todo = await ethers.getContractFactory("Todo");
    todo = await Todo.deploy();
    await todo.deployed();
  })

  it("Should Create Task", async function() {
    const before = await todo.getUserTasks(admin.address)
    await todo.createTask("Go to Market", "Isaac Frank")
    const after = await todo.getUserTasks(admin.address)
    expect(before.length).lt(after.length)
  })
  
  it("Should Get User's Task By ID", async function() {
    const task = await todo.getSingleUserTask(admin.address, 0)
    expect(task.task).to.equal("Go to Market");
  });
  
  it("Should Get All User's Tasks", async function() {
    const tasks = await todo.getUserTasks(admin.address);
    expect(tasks).to.not.be.empty;
  });
  
  it("Should Update Task's Fields", async function() {
    const newDate = (Date.now() / 1000).toFixed(0);
    await todo.updateTask(0, "Changed", "Isaac", newDate, false);
    const task = await todo.getSingleUserTask(admin.address, 0)
    expect(task.task).to.equal("Changed");
    expect(task.owner).to.equal("Isaac");
    expect(task.date).to.equal(newDate);
    expect(task.isDone).to.equal(false);
  });
  
  it("Should Update Task's Task Field", async function() {
    await todo.updateTaskText(0, "Learn to Code");
    const task = await todo.getSingleUserTask(admin.address, 0)
    expect(task.task).to.equal("Learn to Code");
  });

  it("Should Update Task's Author Field", async function() {
    await todo.updateTaskOwner(0, "Emily Morgan");
    const task = await todo.getSingleUserTask(admin.address, 0)
    expect(task.owner).to.equal("Emily Morgan");
  });

  it("Should Update Task's Date Field", async function() {
    const newDate = (Date.now() / 1000).toFixed(0);
    await todo.updateTaskDate(0, newDate);
    const task = await todo.getSingleUserTask(admin.address, 0)
    expect(task.date).to.equal(newDate);
  });

  it("Should Update Task's isDone Field", async function() {
    const oldTask = await todo.getSingleUserTask(admin.address, 0)
    await todo.updateTaskStatus(0, !oldTask.isDone);
    const updatedTask = await todo.getSingleUserTask(admin.address, 0)
    expect(updatedTask.isDone).to.not.equal(oldTask.isDone);
    expect(updatedTask.isDone).to.equal(!oldTask.isDone);
  });

  it("Should Mark Task as Completed", async function() {
    await todo.markTaskAsComplete(0);
    const task = await todo.getSingleUserTask(admin.address, 0)
    expect(task.isDone).to.equal(true);
  });

  it("Should Mark Task as Incomplete", async function() {
    await todo.markTaskAsIncomplete(0);
    const task = await todo.getSingleUserTask(admin.address, 0)
    expect(task.isDone).to.equal(false);
  });

  

  it("Should Delete Task from Entry", async function() {
    const oldTasks = await todo.getUserTasks(admin.address)
    await todo.removeUserTask(0);
    const newTasks = await todo.getUserTasks(admin.address)
    expect(oldTasks.length).gt(newTasks.length);
  });


});
