// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.6;

contract Todo {

    struct Task {
        uint id;
        bool isDone;
        uint date;
        string owner;
        string task;
    }

    mapping(address=>Task[]) usersTasks;

    modifier taskExists(address _user, uint256 _id) {
        uint256 uTaskLength = usersTasks[_user].length;
        require(_id <= uTaskLength, "Index doesn't exists");
        _;
    }

    /** 
    * @notice Function responsible for the creation of tasks
    * @param _task The task to be created
    * @param _owner  The author of the task
    */

    function createTask(string memory _task, string memory _owner) public {
        Task memory task_;
        task_.id = usersTasks[msg.sender].length;
        task_.date = block.timestamp;
        task_.owner = _owner;
        task_.task = _task;
        // isDone value is false by default 

        usersTasks[msg.sender].push(task_);
    }

    
    /** 
    * @notice Function responsible for the fetching a user's specific task by id
    * @param _user The creator of the task
    * @param _id The index of the task
    */

    function getSingleUserTask(address _user, uint256 _id) public view taskExists(_user, _id) returns(Task memory task_) {
        task_ = usersTasks[_user][_id];
    }
    
    /** 
    * @notice Function responsible for the fetching all user's
    * @param _user The creator of the tasks
    */

    function getUserTasks(address _user) public view returns(Task[] memory tasks_) {
        tasks_ = usersTasks[_user];
    }
    
    /** 
    * @notice Function responsible for deleting user's task by id
    * @param _user The creator of the tasks
    * @param _id index of array to be deleted
    */

    function removeUserTask(address _user, uint256 _id) public taskExists(_user, _id) {
        // @TODO Make this Gas Efficient
        
        // Shift all array elements backwards which override the task to be deleted, this is not gas efficient 

        for (uint i = _id; i < usersTasks[_user].length-1; i++){
            usersTasks[_user][i] = usersTasks[_user][i+1];
        }

        usersTasks[_user].pop(); // deletes last element
    }
}